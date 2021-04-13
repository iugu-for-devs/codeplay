require 'rails_helper'

describe 'Home page' do
  xit 'view brand' do
    visit root_path

    expect(page).to have_text('Um Projeto muito legal!')
  end
end
