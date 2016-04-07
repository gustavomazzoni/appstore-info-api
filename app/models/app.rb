require 'itunes_api'

class App
  include ActiveModel::Model
  attr_accessor :appId, :appName, :description, :smallIconUrl, 
  				:publisherName, :price, :versionNumber, :averageUserRating

  def self.find_by_id(id)
  	itunes_api = ITunesAPI.new
	app_metadata = itunes_api.lookup(:id => id)
	
	# Create app with metadata
	if !app_metadata.empty?
		app = App.new(
			:appId => id,
			:appName => app_metadata.first["trackName"],
			:description => app_metadata.first["description"],
			:smallIconUrl => app_metadata.first["artworkUrl60"],
			:publisherName => app_metadata.first["sellerName"],
			:price => app_metadata.first["formattedPrice"],
			:versionNumber => app_metadata.first["version"],
			:averageUserRating => app_metadata.first["averageUserRating"]
		)
	# In case app not found on lookup, 
	# create app with empty metadata
	else 
		app = App.new(
			:appId => id,
			:appName => "",
			:description => "",
			:smallIconUrl => "",
			:publisherName => "",
			:price => "",
			:versionNumber => "",
			:averageUserRating => ""
		)
	end

	return app
  end

end