class Bird
  include Mongoid::Document
  	field :name, type: String
  	field :family, type: String
  	field :continents, type: Array
  	field :added, type: String, default: ->{ Date.today }
	  field :visible, type: Mongoid::Boolean, default: false

	# Validations
  	validates :name, :family, :continents, presence: true

	# Scopes
	scope :all_visible, -> { where(visible: true)}

   	def as_json(*args)
    	bird = super
    	bird["id"] = bird.delete("_id").to_s
    	bird
  	end

end
