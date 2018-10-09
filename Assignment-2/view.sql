

   use assignment2_congwen;
   
   

   #Implement View
   
   create view deleveloper_roles_and_privileges as
   
   select firstname,lastname,username, email, website.`name` as web_name ,visits as web_visits, website.updated as web_updated, 
   website_role.role as web_role, website_priviledge.priviledge as web_priviledge, title as page_title, views as page_views, 
   `page`.updated as page_updated, page_role.role as page_role_, page_priviledge.priviledge as page_priviledge_

   from person join developer on (person.id=developer.id) join website_role on (developer.id=website_role.developer_id) 
        join website_priviledge on (website_role.web_id=website_priviledge.web_id and developer.id=website_priviledge.developer_id) 
        join website on (website_role.web_id=website.id) left join `page` on (website.id=`page`.web_id) 
        left join page_role on (`page`.id=page_role.page_id and developer.id=page_role.developer_id) 
        left join page_priviledge on (`page`.id=page_priviledge.page_id and developer.id=page_priviledge.developer_id);
