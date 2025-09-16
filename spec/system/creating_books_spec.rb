require 'rails_helper'

RSpec.describe "CreatingBooks", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'creates a valid book (integration test)' do
    visit '/books/new'
    
    fill_in 'book_title', with: 'A Title'
    fill_in 'book_author', with: 'An Author'
    fill_in 'book_price', with: '9.99'
    select Date.today.to_s, from: 'book_published_date'
    
    click_on 'Create Book'
    
    expect(page).to have_content('Book Created')
  end

  # --- TITLE --- #
  it 'creates a book with an invalid title (unit test)' do
    book = Book.create(title: '', author: 'An Author', price: 9.99, published_date: Date.today.to_s)
    expect(book.errors[:title]).not_to be_empty
  end

  it 'creates a book with an invalid title (integration test)' do
    visit '/books/new'
    
    fill_in 'book_title', with: ''
    fill_in 'book_author', with: 'An Author'
    fill_in 'book_price', with: '9.99'
    select Date.today.to_s, from: 'book_published_date'
    
    click_on 'Create Book'
    
    expect(page).to have_content('Title can\'t be blank')
  end

  # --- AUTHOR --- #
  it 'creates a book with an invalid author (unit test)' do
    book = Book.create(title: 'A Title', author: '', price: 9.99, published_date: Date.today.to_s)
    expect(book.errors[:author]).not_to be_empty
  end

  it 'creates a book with an invalid author (integration test)' do
    visit '/books/new'
    
    fill_in 'book_title', with: 'A Title'
    fill_in 'book_author', with: ''
    fill_in 'book_price', with: '9.99'
    select Date.today.to_s, from: 'book_published_date'
    
    click_on 'Create Book'
    
    expect(page).to have_content('Author can\'t be blank')
  end

  # --- PRICE --- #
  it 'creates a book with an invalid price (unit test)' do
    book = Book.create(title: 'A Title', author: 'An Author', price: -1, published_date: Date.today.to_s)
    expect(book.errors[:price]).not_to be_empty
  end

  it 'creates a book with an invalid price (integration test)' do
    visit '/books/new'
    
    fill_in 'book_title', with: 'A Title'
    fill_in 'book_author', with: 'An Author'
    fill_in 'book_price', with: -1
    select Date.today.to_s, from: 'book_published_date'
    
    click_on 'Create Book'
    
    expect(page).to have_content('Price must be greater than or equal to 0')
  end

  # --- PUBLISHED DATE --- #
  it 'creates a book with an invalid published date (unit test)' do
    book = Book.create(title: 'A Title', author: 'An Author', price: 9.99, published_date: nil)
    expect(book.errors[:published_date]).not_to be_empty
  end

  it 'creates a book with the pre-filled publication date (integration test)' do
    visit '/books/new'
    
    fill_in 'book_title', with: 'A Title'
    fill_in 'book_author', with: 'An Author'
    fill_in 'book_price', with: '9.99'
    
    click_on 'Create Book'
    
    expect(page).to have_content('Book Created')
  end
end
