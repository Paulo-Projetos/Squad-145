*** Settings ***
Library    RequestsLibrary
Resource    ../../resources/Authorized.resource
Resource    ../../resources/Users.resource
Resource    ../../resources/books.resource


*** Test Cases ***
Create User
    Create User

Generate Token
    Create Token

Authorize User
    Authorized User

List Books
    Get Books

Add Book To User
    Add Book

Get User Info After Add
    Get User With Book

Delete Book
    Delete Book

Get User Info After Delete
    Get User Without Book

Delete User
    Delete User

Get Deleted User
    Get Deleted User