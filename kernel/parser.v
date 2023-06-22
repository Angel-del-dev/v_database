module kernel
import os { input }
import kernel {
	into_op, create_op,
	get_op, insert_op,
	change_op, remove_op,
	alter_op, working_op,
	key_in_map
}

fn output_error(args []string) {
	print('A flag must be specidied, call -h to get help')
}

fn parse(query string) {
	main_operation_dict := {
		'INTO': into_op, 'CREATE': create_op, 'GET': get_op,
		'INSERT': insert_op, 'CHANGE': change_op,
		'REMOVE': remove_op, 'ALTER': alter_op, 'WORKING_ON': working_op
	}
	mut query_array := query.split(' ')
	main_operation := query_array[0].to_upper()
	query_array.delete(0)
	exists := key_in_map(main_operation_dict, main_operation)
	if !exists {
		print('Operation not found "$main_operation"\n')
	}else{
		main_operation_dict[main_operation](query_array)
	}
}

fn interface_mode(args []string) {
	for {
		inp := input('> ')
		if inp.to_upper() == 'EXIT' { break }
		parse(inp)
	}
}

fn read_file(args []string) {

}
pub fn type_of_execute(args []string) {
	size := args.len
	size_dict := { '1': output_error, '2': interface_mode, '3': read_file }
	size_dict[size.str()](args)
}
