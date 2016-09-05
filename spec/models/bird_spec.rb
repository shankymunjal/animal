require "rails_helper"

RSpec.describe Bird, type: :model do
  let( :bird) { Bird.new}
  context "attributes" do
    [ :added, :continents, :family, :name, :visible].each do | _attr|
      it "should respond to attributes: #{ _attr}" do
        expect(bird).to respond_to( _attr)
      end
    end
  end

  it "should return only visible birds " do
    eagle = Bird.create(added: Date.today, continents: ["Asia", "Australia"], family: 'loons', name: "Eagle")
    sparrow = Bird.create(added: Date.today, continents: ["Asia", "Australia"], family: 'grebes', name: "Sparrow", visible: true)

    expect(Bird.all_visible).to eq([sparrow])
  end


end
