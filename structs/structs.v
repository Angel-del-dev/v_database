module structs

// To create default values for function parameters, we can create a struct and assign it a default value to the property
pub struct Split_by_delimiter{
	pub :
		str string
		delimiter string = ';;;'
}

pub struct Check_db {
	pub:
		name string
		neg bool
		route string
}

pub struct Col {
	pub:
		name string
		col_type string
		length int
		options []string
}
pub struct Table_col {
	pub:
		cols []Col
}

pub struct Json_decode_type {
	pub:
		name string
}