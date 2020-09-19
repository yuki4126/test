module ApplicationHelper
    # 日時フォーマット
    def simple_time(time)
        time.strftime("%Y/%m/%d %H:%M")
    end
    def current_user
     if session[:user_id]
      @current_user = @current_user || User.find_by(id: session[:user_id])
     end
    end
end