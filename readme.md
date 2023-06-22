V Database

# To compile the database
`compiler.bat`

# Execute the database in interface mode
`program.exe -i`

# Instructions
+ Working features: 
  + Create databases
  + Change the active database
  + Get the database you are working with
  + Create tables
+ Planned: 
+ Todo: 
# Manual

## Example for creating a database
`create database new_database`

## Example for changing the active database
`into new_database`

## Example for geting the active database
`working_on`

## Example for creating a table
```agsl
// Column definitions must be separed with a whitespace
// The syntax is the following:
// col_name:col_type:length:configuration
// Configuration is separated by comma and no space
// Configuration types:
// Auto increment: ai
// Unique: unique
create table new_table id:int:11:ai,unique name:varchar:300
```