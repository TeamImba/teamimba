class Admin::ApplicationController < ApplicationController
  before_filter :admin_required
  
end