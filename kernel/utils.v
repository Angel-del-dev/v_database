module kernel
import structs { Check_db, Table_col, Col }

pub fn to_generic<P, R>(to_cast P) R {
	return R(to_cast)
}

pub fn key_in_map(arr  map[string]fn ([]string), key string) bool{
	mut result := false
	for k in arr.keys() {
		if k == key { result = true }
	}
	return result
}

pub fn check_db(params Check_db) bool {
	op := !params.neg
	mut route := params.route
	name := params.name
	if route == '' { route = './dbs' }

	list_dir := get_folder_contents(route)

	for dir in list_dir {
		if name == dir { return op }
	}
	return !op
}


fn get_types() map[string][]string {
	return { 'int': ['ai', 'unique'], 'varchar': ['unique'] }
}

pub fn is_col_type_allowed(col_type string) bool {
	mut result := false
	types := get_types()
	keys := types.keys()
	for k in keys {
		if k == col_type{
			return true
		}
	}
	return result
}
pub fn are_options_allowed_by_type(column_type string, options[]string) bool {
	mut result := false

	types := get_types()

	for option in options {
		for allowed_type in types[column_type] {
			if option == allowed_type {
				result = true
				break
			}
			else { result = false }
		}

		if !result { print('"$option" is not allowed as a configuration parameter in "$column_type"\n') }
	}

	return result
}

pub fn merge_cols(arr1 Table_col, arr2 Table_col) Table_col {
	mut cols :=  []Col{}
	for col in arr1.cols {
		mut found := false
		for col2 in arr2.cols {
			if col2 == col {
				found = true
			}
		}

		if found {
			cols << col
		}
	}

	for col in arr2.cols {
		mut found := false
		for col2 in arr1.cols {
			if col2 == col {
				found = true
			}
		}

		if found {
			cols << col
		}
	}

	return Table_col{ cols: cols }
}