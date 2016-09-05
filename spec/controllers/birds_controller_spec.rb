require "rails_helper"

RSpec.describe BirdsController, type: :controller do
  
  describe "GET #index" do
      let(:eagle) {Bird.create(added: Date.today, continents: ["Asia", "Australia"], family: 'loons', name: "Eagle")}
      let(:sparrow) {Bird.create(added: Date.today, continents: ["Asia", "Australia"], family: 'grebes', name: "Sparrow", visible: true)}


    it "responds successfully with an HTTP 200 status code when admin is requesting" do
      eagle
      sparrow
      get :index
      json = JSON.parse(response.body)
      expect(json['birds'].length).to eq(1)
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    it "responds successfully with an HTTP 201 status code" do
      post :create, {bird: { name: "penguin", continents: ['Antartica'], family: 'pelicans' } }
      bird = Bird.last
      expect(bird.name).to eq('penguin')
      expect(response).to have_http_status(201)
    end

    it "responds successfully with an HTTP 400 status code when name is blank" do
      post :create, {bird: { name: "", continents: ['Antartica'], family: 'pelicans' } }
      expect(response).to have_http_status(400)
    end    
  end

  describe "GET #show" do
    let(:sparrow) {Bird.create(added: Date.today, continents: ["Asia", "Australia"], family: 'grebes', name: "Sparrow", visible: true)}

    it "retun bird if found by id " do
      sparrow
      get :show, {id:  sparrow.id}
      json = JSON.parse(response.body)
      expect(json['bird']['id']).to eq(sparrow.id.to_s)
      expect(response).to have_http_status(200)
    end
    it "retun 404 when bird not found " do
      get :show, {id:  "randomid"}
      json = JSON.parse(response.body)
      expect(response).to have_http_status(404)
    end
  end

end