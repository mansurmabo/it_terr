class PostsController < ApplicationController
  TOP_NUMBER = 10

  def index
    count = params[:number] ? params[:number] : TOP_NUMBER
    posts = Post.select('posts.id, posts.title, posts.description, avg(ratings.mark)')
      .joins(:ratings)
      .group('posts.id')
      .order('avg(ratings.mark) desc')
      .first(count)

    json_response(posts)
  end

  def create
    user = fetch_user(params[:login])
    return fail_response(user) unless user.instance_of? User

    post = user.posts.new(posts_params(params).merge(ip_address: request.remote_ip))
    begin post.save
      json_response(post)
    rescue => e
      fail_response(e.message)
    end
  end

  def estimate
    post_id = params[:id]
    mark = params[:mark]
    raise ArgumentError, 'Post id not found' if post_id.blank?
    raise ArgumentError, 'Estimate not found' if mark.blank?
    post = Post.find_by(id: post_id)
    post.ratings.create(mark: mark.to_i)

    json_response(post.average)
  rescue ArgumentError => e
    fail_response(e.message)
  end

  def ip_addresses
    #TODO: get users login in array, now select only posts where ip_address count > 1

    posts = Post.select('ip_address').group(:ip_address).having("count(*) > 1").all
    json_response(posts)
  end

  private

  def posts_params(params)
    params.permit(:title, :description)
  end

  def fetch_user(login)
    User.find_or_create_by(login: login)
  rescue => e
    e.message
  end

end
