module ApplicationHelper
  def set_class(class_true, class_false, condition)
    if condition
      return class_true
    else
      return class_false
    end
  end

  def load_photo(product, index)
    case index
      when 1
        return image_tag product.photos.first.photo.url(:thumb), :class => "preview-image"
      when 2
        return image_tag product.photos.second.photo.url(:thumb), :class => "preview-image"
      when 3
        return image_tag product.photos.third.photo.url(:thumb), :class => "preview-image"
      when 4
        return image_tag product.photos.fourth.photo.url(:thumb), :class => "preview-image"
      when 5
        return image_tag product.photos.fifth.photo.url(:thumb), :class => "preview-image"
      else
        return nil
    end
  end
end
