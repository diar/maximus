class Admin::PhotosController < ApplicationController
  before_filter :admin_authorize
end
