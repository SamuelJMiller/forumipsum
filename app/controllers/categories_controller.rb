class CategoriesController < ApplicationController
    def new
        if current_user and current_user.role > 1
            @category = Category.new
        end
    end

    def create
        if current_user and current_user.role > 1
            @category = Category.create(category_params)

            if @category.save
                redirect_to root_path
            end
        end
    end

    private

    def category_params
        params.require(:category).permit(:name)
    end
end
