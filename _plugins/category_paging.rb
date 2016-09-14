require 'pp'

module Jekyll
	class CategoryPostNavigation < Generator
		def generate(site)
			site.collections.each_pair do |collection, posts|
            #pp 'Processing Collection:'+collection
				posts.docs.sort! { |a,b| b.data["order"] <=> a.data["order"]}
				posts.docs.each do |post|
                #pp 'Post:'+post.data["title"]
					index = posts.docs.index post
					next_page = nil
					previous_page = nil
					if index
						if index < posts.docs.length - 1
							previous_page = posts.docs[index + 1]
						end
						if index > 0
							next_page = posts.docs[index - 1]
						end
					end
					post.data["next_page"] = next_page unless next_page.nil?
					post.data["previous_page"] = previous_page unless previous_page.nil?
				end
			end
		end
	end
end