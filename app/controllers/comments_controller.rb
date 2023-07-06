class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    @comments = []
    # @comments = Comment.all
    # @comments = Post.where('comments._id' => BSON::ObjectId(params["id"])).first.comments.where('_id'=>params["id"])
    posts =  Post.all.entries
    posts.each do |post|
      @comments << post.comments.entries.flatten
    end
    @comments
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    post = Post.find(params["comment"]["post_id"])
    @comment = post.comments.new(comment_params)

    respond_to do |format|
      if @comment.save!
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      # @comment = comment.find(params["id"]).post.comment
      @comment = Post.where('comments._id' => BSON::ObjectId(params["id"])).first.comments.where('_id'=>params["id"]).first
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:name, :message, :post_id)
    end
end
