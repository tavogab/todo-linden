class SessionsController < Devise::SessionsController

  def new
    render :layout => 'signin_layout'
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    if is_navigational_format?
      sign_in(resource_name, resource)
      redirect_to root_url, :flash => { :success => "Welcome #{current_user.first_name}" } 
    else
      flash.now[:error] = "Email/password incorrect.Try again"    
      render action: "new", :layout => 'signin_layout'
    end
  end

  def destroy
    redirect_path = root_url
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to redirect_path }
      format.all do
        head :no_content
      end
    end
  end

  
end
