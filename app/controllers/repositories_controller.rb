
class RepositoriesController < ApplicationController

  # def index
  #   github = GithubService.new
  #   @repos = github.get_repos
  #   @username = github.get_username(session[:token])
  # end

  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req['Authorization'] = "token #{session[:token]}"
      req['Accept'] = 'application/json'
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos", {name: params[:name]}.to_json, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    redirect_to '/'
  end
end


