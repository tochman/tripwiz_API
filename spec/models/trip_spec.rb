require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :destination }
    it { is_expected.to have_db_column :lat }
    it { is_expected.to have_db_column :lng }
  end
end
