ActiveAdmin.register_page "Dashboard" do
	menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

	content title: proc { I18n.t("active_admin.dashboard") } do
		div class: "px-4 py-16 md:py-32 text-center m-auto max-w-7xl" do
			div class: "bg-indigo-600 text-white rounded-lg shadow-lg p-8 mb-10" do
				h2 "Welcome to ActiveAdmin", class: "text-3xl font-bold"
				h2 "Manage your application's users, blogs, and comments with ease.", class: "mt-4"
			end

			div class: "grid grid-cols-1 md:grid-cols-3 gap-6 mb-10" do
				div class: "bg-white dark:bg-gray-800 shadow-md rounded-lg p-6 text-center" do
					h3 "Users", class: "text-xl font-semibold text-gray-800 dark:text-gray-200"
					para "#{User.count}", class: "text-4xl font-bold text-indigo-600 dark:text-indigo-400"
					para "Total Users", class: "text-gray-600 dark:text-gray-400"
					div class: "mt-4" do
						para link_to("View Users", admin_users_path, class: "text-blue-600 underline")
					end
				end

				div class: "bg-white dark:bg-gray-800 shadow-md rounded-lg p-6 text-center" do
					h3 "Blogs", class: "text-xl font-semibold text-gray-800 dark:text-gray-200"
					para "#{Blog.count}", class: "text-4xl font-bold text-gray-800 dark:text-gray-200"
					para "Total Blogs", class: "text-gray-600 dark:text-gray-400"
					div class: "mt-4" do
						para link_to("View Blogs", admin_blogs_path, class: "text-blue-600 underline")
					end
				end

				div class: "bg-white dark:bg-gray-800 shadow-md rounded-lg p-6 text-center" do
					h3 "Comments", class: "text-xl font-semibold text-gray-800 dark:text-gray-200"
					para "#{BlogComment.count}", class: "text-4xl font-bold text-gray-800 dark:text-gray-200"
					para "Total Comments", class: "text-gray-600 dark:text-gray-400"
					div class: "mt-4" do
						para link_to("View Comments", admin_blog_comments_path, class: "text-blue-600 underline")
					end
				end
			end
		end
	end
end
