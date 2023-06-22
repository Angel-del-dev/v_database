module kernel
import os { 
	read_file, write_file,
	rm, ls, mkdir
}
import structs { Split_by_delimiter }

pub fn read(file_name string) string {

    data := read_file(file_name) or {
        panic('error reading file $file_name')
        return '0'
    }
    return data
}

pub fn write(file_name string, text string) {
	write_file(file_name, text) or {
		panic('error reading file $file_name')
	}
}

pub fn remove(file_name string) {
	rm(file_name) or {
		panic('error reading file $file_name')
	}
}

pub fn get_folder_contents(path string) []string {
	return ls(path) or {
		return []
	}
}

pub fn split_by_delimiter(params Split_by_delimiter) []string {
	return params.str.split_any(params.delimiter)
}

pub fn make_folder(path string) {
	mkdir(path) or {
		panic('Route "$path" is not available')
	}
}

pub fn check_table_exists(path string, table string) bool {
	tables := get_folder_contents(path)
	for t in tables{
		if t == table { return true }
	}
	return false
}