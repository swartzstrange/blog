module Authors

  class ElementsController < AuthorsController
    before_action :set_post
    before_action :set_element, only: [:update, :destroy]

    def create
      @element= @post.elements.build(element_params)

      respond_to do |format|
        if @element.save
          format.html { redirect_to edit_post_path(@post) }
        else
          format.html { redirect_to edit_post_path (@post), @element.errors.full_messages.join('. ') <<'.' }
        end
      end
    end

    # PATCH/PUT /elements/1
    # PATCH/PUT /elements/1.json
    def update
      respond_to do |format|
        @element.update(element_params)
          format.html { redirect_to edit_post_path(@element.post) }
      end
    end

    # DELETE /elements/1
    # DELETE /elements/1.json
    def destroy
      @element.destroy
      respond_to do |format|
        format.html { redirect_to edit_post_path(@element.post) }
        format.json { head :no_content }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_author.posts.find(params[:post_id])
    end

    def set_element
      @element = @post.elements.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def element_params
      params.require(:element).permit(:element_type, :content, :image)
    end
  end
end
