require 'rails_helper'

RSpec.feature "Show Article" do

  before do
    @john = User.create(email: 'john@example.com', password: 'password')
    @fred = User.create(email: 'fred@example.com', password: 'password')
    @article = Article.create(title: 'Article title', body: 'Article body', user: @john)
  end

  scenario 'to non-signed in user hide the edit and delete buttons' do
    visit '/'

    click_link @article.title

    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    expect(current_path).to eq article_path(@article)
    expect(page).not_to have_link 'Edit Article'
    expect(page).not_to have_link 'Delete Article'
  end

  scenario 'to non-owner user hide the edit and delete buttons' do
    login_as @fred
    visit '/'

    click_link @article.title

    expect(page).to have_content @article.title
    expect(page).to have_content @article.body
    expect(current_path).to eq article_path(@article)
    expect(page).not_to have_link 'Edit Article'
    expect(page).not_to have_link 'Delete Article'
  end
end