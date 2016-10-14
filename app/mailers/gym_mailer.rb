class GymMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.gym_mailer.gymcreated.subject
  #
  def gymcreated(gym_manager, gym)
    @gym_manager = gym_manager
    @gym = gym

    mail(to: @gym_manager.email,
         subject: "Gym #{gym.name} created"
        )
  end
end
