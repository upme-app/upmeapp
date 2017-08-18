::Spina::Theme.register do |theme|

  theme.name = 'default'
  theme.title = 'Post'

  theme.page_parts = [{
    name:           'text',
    title:          'Text',
    partable_type:  'Spina::Text'
  },{
      name:           'subtitle',
      title:          'Subtitle',
      partable_type:  'Spina::Line'
  },{
    name:           'post_logo',
    title:          'Post Logo',
    partable_type:  'Spina::Photo'
  }]

  theme.view_templates = [{
    name:       'homepage',
    title:      'Homepage',
    page_parts: ['photo', 'text']
  }, {
    name: 'show',
    title:        'Default',
    description:  'A simple page',
    usage:        'Use for your content',
    page_parts:   ['post_logo', 'subtitle', 'text']
  }]

  theme.custom_pages = [{
    name:           'homepage',
    title:          'Homepage',
    deletable:      false,
    view_template:  'homepage'
  }]

  theme.navigations = [{
    name: 'mobile',
    label: 'Mobile'  
  }, {
    name: 'main',
    label: 'Main navigation',
    auto_add_pages: true
  }]

end
