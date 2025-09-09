require 'rails_helper'

RSpec.describe "CreatingBooks", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'creates a valid book (integration test)' do
    visit '/books/new'
    
    fill_in 'book_title', with: 'A Title'
    
    click_on 'Create Book'
    
    expect(page).to have_content('Book Created')
  end

  it 'creates a book with an invalid title (unit test)' do
    book = Book.new(title: '')
    expect(book.save).to be false
  end

  it 'creates a book with an invalid title (integration test)' do
    visit '/books/new'
    
    fill_in 'book_title', with: ''
    
    click_on 'Create Book'
    
    expect(page).to have_content("Title can't be blank")
  end
end
