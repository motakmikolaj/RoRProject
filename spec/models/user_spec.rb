require 'rails_helper'

RSpec.describe User do
  describe '#missing_resources_for' do
    let!(:user) { FactoryBot.create :user }
    let!(:dragon_type) { FactoryBot.create :dragon_type }

    context 'When dragon is for free' do
      specify 'User is not lacking any resources' do
        expect(user.missing_resources_for(dragon_type).empty?).to eq(true)
        expect(user.can_afford?(dragon_type)).to eq(true)
      end
    end

    context 'When user has to pay resources' do
      let!(:resource_type) { FactoryBot.create :resource_type }
      let!(:dragon_cost) { FactoryBot.create :dragon_cost, dragon_type: dragon_type, resource_type: resource_type, cost: 5 }

      specify 'User does not have any resources' do
        expect(user.missing_resources_for(dragon_type)).to eq([{ quantity: 5, resource: dragon_cost }])
        expect(user.can_afford?(dragon_type)).to eq(false)
      end

      let!(:dragon_type2) { FactoryBot.create :dragon_type }
      let!(:resource_type2) { FactoryBot.create :resource_type }
      let!(:dragon_cost2) { FactoryBot.create :dragon_cost, dragon_type: dragon_type2, resource_type: resource_type2, cost: 5 }
      let!(:resource2) { FactoryBot.create :resource, user: user, resource_type: resource_type2, quantity: 4 }

      specify 'User does not have enough resources' do
        expect(user.missing_resources_for(dragon_type2)).to eq([{ quantity: 1, resource: dragon_cost2 }])
        expect(user.can_afford?(dragon_type2)).to eq(false)
      end

      let!(:dragon_type3) { FactoryBot.create :dragon_type }
      let!(:dragon_cost3) { FactoryBot.create :dragon_cost, dragon_type: dragon_type3, resource_type: resource_type2, cost: 4 }
      specify 'User has enough resources' do
        expect(user.missing_resources_for(dragon_type3).empty?).to eq(true)
        expect(user.can_afford?(dragon_type3)).to eq(true)
      end
    end
  end
end
