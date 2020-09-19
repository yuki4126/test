Rails.application.routes.draw do
  # user
  get    'users/index' => 'users#index'            #ユーザー一覧ページ
  get    'users/:id' => 'users#show'               #ユーザー詳細ページ
  get    'signup' => 'users#new'                   #新規ユーザー登録ページ
  post   'users/create' => 'users#create'          #新規ユーザー登録機能
  get    'users/:id/edit' => 'users#edit'          #ユーザー編集ページ
  patch  'users/:id/update' => 'users#update'      #ユーザー編集機能
  get    'login' => 'users#login_form'             #ログインページ
  post   'login' => 'users#login'                  #ログイン機能
  delete 'logout' => 'users#logout'                #ログアウト機能
  get    'users/:id/likes' => 'users#likes'        #いいね投稿一覧ページ
  
  # home
  get    '/' => 'home#top'                         # TOPページ
  get    'about' => 'home#about'                   # アプリ概要ページ
  
  # post
  get    'posts/index' => 'posts#index'            # 投稿一覧ページ
  get    'posts/new' => 'posts#new'                # 投稿ページ
  get    'posts/:id/edit' => 'posts#edit'          # 投稿編集ページ
  get    'posts/:id' => 'posts#show'               # 投稿詳細ページ
  post   'posts/create' => 'posts#create'          # 新規投稿機能
  patch  'posts/:id/update' => 'posts#update'      # 投稿編集機能
  delete 'posts/:id/destroy' => 'posts#destroy'    # 投稿削除機能
  
  # like
  post   'likes/:post_id/create' => 'likes#create' # いいね！ボタン
  delete 'likes/:post_id/destroy'=> 'likes#destroy'# いいね！取り消しボタン
end