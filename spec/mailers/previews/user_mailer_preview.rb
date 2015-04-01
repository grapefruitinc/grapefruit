class UserMailerPreview < ActionMailer::Preview
  def new_announcement
    UserMailer.new_announcement(User.first, User.last, Course.first, "Sample Subject", %(

    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce et porta lectus. Etiam metus risus, blandit eget faucibus et, accumsan a diam. Mauris eu purus nibh. Praesent fermentum neque ac augue dictum suscipit. Curabitur vulputate est eu odio mollis, cursus feugiat nisl aliquam. Curabitur pharetra faucibus sapien, nec egestas ante tempor nec. In luctus efficitur nisl, hendrerit placerat purus congue nec. Etiam at mi diam.

Ut tincidunt quam quis libero pretium fermentum. Fusce id nisl lobortis, ultrices libero eu, interdum sem. Ut in facilisis neque. Donec aliquam eleifend enim, at luctus ante lobortis nec. Phasellus pellentesque, neque et ullamcorper convallis, est purus consequat est, in ultrices orci sem ut lectus. Suspendisse mattis erat sit amet erat iaculis condimentum. Nunc feugiat nunc tortor, quis malesuada enim iaculis sed. Etiam porttitor mi ac lobortis fermentum. Maecenas molestie, diam quis dignissim tincidunt, erat ex ornare quam, sit amet blandit ante ante vitae magna.

Curabitur quis est ac urna feugiat porta. Nulla lacinia augue neque, et auctor erat scelerisque et. Curabitur ac tortor non odio maximus dignissim eu vel dui. Proin faucibus leo a tortor ultricies sollicitudin vel a enim. Maecenas mollis tincidunt purus. Suspendisse potenti. Ut vel lectus sed odio egestas egestas.

Phasellus malesuada ipsum at tortor convallis, eget aliquet augue rhoncus. Integer vitae sagittis enim. Nam viverra aliquet neque a sollicitudin. Donec ex nunc, commodo eget arcu nec, ornare facilisis nibh. Nunc tincidunt felis ut magna lacinia molestie. Phasellus augue massa, pretium sed semper ac, commodo non mauris. Aenean vel vulputate risus, sit amet semper tellus.

Nulla at sapien ex. Maecenas sodales bibendum eros vitae vulputate. Maecenas sed neque at velit aliquet sollicitudin. Aenean facilisis purus ut odio consequat, sit amet hendrerit lorem rhoncus. Mauris augue magna, vehicula et lorem ut, ultricies mattis nulla. Praesent felis lorem, porta non dictum et, bibendum finibus felis. Sed lobortis neque dui, eget ullamcorper ex imperdiet eget. Sed et faucibus enim, nec maximus sapien. Praesent felis dui, facilisis a tincidunt non, sollicitudin sit amet diam.

    ))
  end
  def new_assignment
    UserMailer.new_assignment(User.first, Course.first, Assignment.first)
  end
end
