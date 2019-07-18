class UserPolicy < ApplicationPolicy
  def edit?
    current_user?
  end

  def onboarding_update?
    true
  end

  def update?
    current_user?
  end

  def update_twitch_username?
    current_user?
  end

  def update_language_settings?
    current_user?
  end

  def destroy?
    current_user?
  end

  def join_org?
    !user_is_banned?
  end

  def leave_org?
    OrganizationMembership.exists?(user_id: user.id, organization_id: record.id)
  end

  def remove_association?
    current_user?
  end

  def dashboard_show?
    current_user? || user_admin? || minimal_admin?
  end

  def pro_user?
    current_user? && user.has_role?(:pro)
  end

  def moderation_routes?
    user.has_role?(:trusted) && !user.banned
  end

  def permitted_attributes
    %i[
      available_for
      behance_url
      bg_color_hex
      config_font
      config_theme
      contact_consent
      currently_hacking_on
      currently_learning
      display_sponsors
      dribbble_url
      editor_version
      education
      email
      email_badge_notifications
      email_comment_notifications
      email_community_mod_newsletter
      email_connect_messages
      email_digest_periodic
      email_follower_notifications
      email_membership_newsletter
      email_mention_notifications
      email_newsletter
      email_public
      email_tag_mod_newsletter
      email_unread_notifications
      employer_name
      employer_url
      employment_title
      experience_level
      export_requested
      facebook_url
      feed_admin_publish_permission
      feed_mark_canonical
      feed_referential_link
      feed_url
      gitlab_url
      inbox_guidelines
      inbox_type
      instagram_url
      linkedin_url
      location
      looking_for_work
      looking_for_work_publicly
      mastodon_url
      medium_url
      mobile_comment_notifications
      mostly_work_with
      name
      password
      password_confirmation
      permit_adjacent_sponsors
      profile_image
      stackoverflow_url
      summary
      text_color_hex
      twitch_url
      twitch_username
      username
      website_url
    ]
  end

  private

  def not_self?
    user != record
  end

  def current_user?
    user == record
  end
end
