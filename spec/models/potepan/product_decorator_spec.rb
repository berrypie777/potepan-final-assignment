require 'rails_helper'

RSpec.describe Potepan::ProductDecorator, type: :model do
  describe "#related_products" do
    let(:taxon) { create(:taxon) }
    let(:taxon2) { create(:taxon) }
    let(:product) { create(:product, taxons:[taxon, taxon2]) }
    let(:related_products) { create_list(:product, 5, taxons:[taxon, taxon2]) }
    let(:unrelated_product) { create(:product) }

    it "returns related products correctly" do
      related_products.each do |related_product|
        expect(product.related_products).to include(related_product)
      end
        expect(product.related_products).to_not include(unrelated_product)
        expect(product.related_products).to_not include(product)
    end

    it "No duplication of related products" do
      expect(product.related_products).to eq(product.related_products.uniq)
    end
  end
end
