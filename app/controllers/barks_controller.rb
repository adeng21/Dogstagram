class BarksController < ApplicationController

  def create
    post = Post.find(params[:post_id])

    bark = current_user.barks.build(post: post)

    if bark.save
      redirect_to :back, notice: "We hear you Bark!"
    else
      redirect_to :back
    end
  end

  def destroy
    current_user.barks.destroy(params[:id])
    redirect_to :back, notice: "All evidence of your barking has been destroyed!"
  end
end
