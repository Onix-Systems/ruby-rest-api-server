FactoryGirl.define do
  factory :product do
    gtin 4_820_001_356_298
    bar_code_type 'EAN_UCC_13_SYMBOL'
    unit_descriptor 'BASE_UNIT_OR_EACH'
    internal_supplier_code 'CH05060104UA'
    brand_name 'Chumak'
    description_short 'Chumak Sause Chumak Kherson glass 500 g'
  end
end
