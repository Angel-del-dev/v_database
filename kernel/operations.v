module kernel

import kernel {
	check_db, make_folder,
	are_options_allowed_by_type, is_col_type_allowed,
	write, get_folder_contents,
	check_table_exists
}
import structs { Check_db, Table_col, Col }

import json

// Global variables are mutable
__global (
	active_db string
)

// Start db info
pub fn working_op(query_array []string) {
	print("$active_db\n")
}
pub fn into_op(query_array []string) {
	name := query_array[0]
	exists := check_db(Check_db{
		name: name,
		neg: false
	})
	if exists {
		active_db = name
	}else {
		print('Database "$name" does not exist\n')
	}
}
// End db info
fn get_table_config(name string) Table_col{
	table_contents := get_folder_contents('./dbs/$active_db/tables/$name')
	mut result := Table_col{}
	for element in table_contents {
		if element == 'config.json' {
			existing_config := read('./dbs/$active_db/tables/$name/config.json')

			result = json.decode(Table_col, existing_config) or {
				panic('Could not convert')
			}

			break
		}
	}
	return result
}
fn create_table_cols(name string, c_query_array []string) Table_col {
	mut cols := []Col{}
	mut error := false
	for col in c_query_array {
		mut conf := col.split(':')
		col_name := conf[0]
		conf.delete(0)
		col_type := conf[0]
		conf.delete(0)
		length := conf[0]
		conf.delete(0)
		options := conf[0].split(',')

		is_allowed := is_col_type_allowed(col_type)
		if !is_allowed {
			print('Column type "$col_type" does not exist\n')
			error = true
		}

		if conf.len > 0 && !error {
			error = !are_options_allowed_by_type(col_type, options)
		}

		if !error {
			cols << Col{
				name: col_name
				col_type: col_type
				length: length.int()
				options: options
			}
		}


	}

	return Table_col{ cols: cols }
}
fn create_table(query_array []string) {
	mut error := false
	if active_db == '' {
		print('No database selected\n')
		error = true
	}
	if !error && sizeof(query_array) < 2 {
		print('Insuficient parameters for the create table operation\n')
		error = true
	}

	if !error {
		mut c_query_array := query_array.clone()
		table_name := c_query_array[0]
		c_query_array.delete(0)
		cols_dict := create_table_cols(table_name, c_query_array)

		error = check_table_exists('./dbs/$active_db/tables', table_name)
		if !error {
			json_cols := json.encode(cols_dict)
			make_folder('./dbs/$active_db/tables/$table_name')
			write('./dbs/$active_db/tables/$table_name/config.json', json_cols)
		}else {
			print('Table $table_name already exists\n')
		}
	}
}

fn create_database(query_array []string) {
	name := query_array[0]
	res := check_db(Check_db{
		name: name
		neg: true
	})

	if !res { print("Database $name already exists\n") }
	else {
		make_folder('./dbs/$name')
		make_folder('./dbs/$name/tables')
	}
}
pub fn create_op(query_array []string) {
	mut c_query_array := query_array.clone()
	if sizeof(query_array) >= 2 {

		type_of_create := c_query_array[0].to_upper()
		c_query_array.delete(0)

		types := { 'TABLE': create_table, 'DATABASE': create_database }
		exists := key_in_map(types, type_of_create)
		if !exists {
			print('Operation not found "$type_of_create"\n')
		}else{
			types[type_of_create](c_query_array)
		}

	}else { print('Insuficient parameters for the create operation') }
}
pub fn get_op(query_array []string) {

}
pub fn insert_op(query_array []string) {

}
pub fn change_op(query_array []string) {

}
pub fn remove_op(query_array []string) {

}
pub fn alter_op(query_array []string) {

}
