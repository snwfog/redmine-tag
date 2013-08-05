resources :tag_descriptors
resources :issues do
  resources :tags, shallow: true
end
