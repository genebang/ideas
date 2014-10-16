module ApplicationHelper

  def markdown(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_codeblock]
    Markdown.new(text, *options).to_html.html_safe
  end

  def markdown_excerpt(text)
    options = [:filter_html, :no_images, :no_links, :lax_spacing]
    Markdown.new(text, *options).to_html.html_safe.gsub(/<[\/\w]+>/, "")
  end

  def distance_with_time(time, index = false)
    divider = index ? "ago<br>at" : "ago at"
    [
      distance_of_time_in_words_to_now(time),
      divider,
      post_time(time)
    ].join(" ").html_safe
  end

  def post_date(time)
    date_format = "%D"
    time.strftime(date_format)
  end

  def post_time(time)
    time_format = "%I:%M %p"
    time.strftime(time_format)    
  end

  def post_date_and_time(time)
    [
      post_date(time),
      " at ",
      post_time(time),
      "PST"
    ].join(" ")
  end

  def owner?(object)
    object.user_id == current_user.id
  end

  def post_info(object) 
    info = object.created_at == object.updated_at ? "Posted on " : "Updated on "
    [
      info,
      post_date_and_time(object.updated_at),
      " by ",
      object.user.email
    ].join(" ")
  end

  def up_vote_icon
    content_tag(:i, nil, class: "icon-thumbs-up") + " Vote Up"
  end

  def down_vote_icon
    content_tag(:i, nil, class: "icon-thumbs-down") +  " Vote Down"
  end

  def up_vote_count(object)
    content_tag :div, object.votes.up_vote.count, class: "up_vote_count display_vote_counts"
  end

  def down_vote_count(object)
    content_tag :div, object.votes.down_vote.count, class: "down_vote_count display_vote_counts"
  end

  def vote_up_link(object)
    link_to up_vote_icon, vote_up_path(object), method: :post, remote: true, class: "vote_up btn btn-primary btn-small"
  end

  def vote_down_link(object)
    link_to down_vote_icon, vote_down_path(object), method: :post, remote: true, class: "vote_down btn btn-primary btn-small"
  end

  def voted_for?(object)
    object.votes.collect(&:user_id).include?(current_user.id)
  end

  def display_voting(object)
    if object.user != current_user && !voted_for?(object)
      [
        vote_up_link(object),
        vote_down_link(object)
      ].join("&nbsp;&nbsp;&nbsp;").html_safe
    else
      # link_to "Revote", nil, class: "btn btn-primary btn-mini revote", remote: true
    end
  end

  def thumbs_up_icon
    content_tag :i, nil, class: "icon-thumbs-up"
  end

  def thumbs_down_icon
    content_tag :i, nil, class: "icon-thumbs-down"
  end

  def display_vote_counts(object)
    [
      thumbs_up_icon,
      up_vote_count(object),
      thumbs_down_icon,
      down_vote_count(object)
    ].join.html_safe
  end

  def image_link(image)
    link_to(image_thumbnail(image), image.url, class: 'image_link', target: "_blank") unless image.blank?
  end

  def image_thumbnail(image)
    image_tag(image.image_url(:thumb).to_s) unless image.blank?
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s + "/form", f: builder)
    end
    link_to(name, "#", class: "add_fields btn btn-primary btn-small", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_comments(name, object, association)
    id = object.id
    # fields = render("comments/form", f: object)
    # link_to(name, "#", data: {id: id, fields: fields: fields.gsub("\n", "")})
  end

  def excerpt(string)
    if string.length > 100
      string[0..100] + "..." 
    else
      string
    end
  end

  def full_title(object)
    [
      category_to_s(object),
      object.title 
    ].join(" ").html_safe
  end

  def category_to_s(object)
    "[" + object.category + "]" unless object.category.empty?
  end

  def archive_link(object)
    link_to "Archive", archive_path(object), method: :post, confirm: "Archive. are you sure?", class: "btn btn-primary btn-small btn-warning"
  end

  def archive_button(object)
    object.archived_at.nil? ? archive_button_active(object) : archive_button_disabled(object)
  end

  def archive_button_active(object)
    link_to "X", archive_path(object), method: :post, remote: true, confirm: "Archive. are you sure?", class: "btn btn-primary btn-mini btn-danger archive"
  end

  def archive_button_disabled(object)
    link_to "X", "#", class: "btn btn-primary btn-mini btn-danger disabled"
  end

  def delete_link(object)
    link_to "Delete", object, method: "delete", confirm: "Delete. Are you sure?", class: "btn btn-primary btn-small btn-danger"
  end

  def display_priority(object)
    object.priority.to_i >= 0 ? object.priority : "--"
  end

end
