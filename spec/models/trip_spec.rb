require 'rails_helper'

RSpec.describe Trip, type: :model do
  describe 'Database table' do
    it { is_expected.to have_db_column :coord_lat }
    it { is_expected.to have_db_column :coord_lng }
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :place_id }
  end
end
