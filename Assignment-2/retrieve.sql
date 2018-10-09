

   use assignment2_congwen;

   #Implement Queries
   
   #Retrieve developers
   #a Retrieve all developers
   
   select person.id, firstname, lastname, username, `password`, email, dob, developer_key
   from person join developer on person.id=developer.id;
   
   #b Retrieve a developer with id equal to 34 (charlie)
   
   select person.id, firstname, lastname, username, `password`, email, dob, developer_key
   from person join developer on person.id=developer.id
   where person.id=34;
   
   #c Retrieve all developers who have a role in Twitter other than owner (charlie, alice)
   
   select person.id, firstname, lastname, username, `password`, email, dob, developer_key, `name`, role
   from person join developer on (person.id= developer.id ) join website_role on (developer_id=developer.id) 
        join website on (website.id=web_id)
   where `name`='twitter' and role not in ('owner');
   
   #d Retrieve all developers who are page reviewers of pages with less than 300000 visits (charlie, bob)
   
   select person.id, firstname, lastname, username, `password`, email, dob, developer_key, title, views
   from person join developer on (person.id= developer.id ) join page_role on (developer_id=developer.id) 
        join `page` on (page_id=`page`.id)
   where role='reviewer' and views<=300000;
    
   #e Retrieve the writer developer who added a heading widget to CNET's home page (charlie)
   
   select person.id, firstname, lastname, username, `password`, email, dob, developer_key, 
          website.`name`,title, page_role.role, a.`name` as wid_name, dtype
   from   (select `name`,page_id,dtype from widget where dtype='heading') as a 
          join (select id,title, web_id  from `page` where title='home') as b
          on (a.page_id=b.id) join website on (website.id=b.web_id) join page_role on (b.id=page_role.page_id) 
          join developer on (developer.id=page_role.developer_id) join person on (person.id=developer.id)
   where  website.`name`= 'cnet' and page_role.role='writer';
   
   
   
   #Retrieve websites
   #a Retrieve the website with the least number of visits
   
   select id, `name`, description, created, updated, min(visits) as least_visit
   from website
   where visits=(select min(visits) from website);
   
   #b Retrieve the name of a website whose id is 678 (Gizmodo)
   
   select id, `name` from website where id=678;
 
   #c Retrieve all websites with videos reviewed by bob (CNN)
   
   select website.`name`, a.`name`, dtype, username, role
   from (select widget.`name`,page_id, dtype from widget where dtype='youtube') as a 
         join `page` on (`page`.id=a.page_id) 
         join website on (website.id=`page`.web_id) join page_role on (page_role.page_id=`page`.id ) 
         join developer on(page_role.developer_id=developer.id) join person on(person.id= developer.id)
	where role='reviewer' and username='bob';
   
   #d Retrieve all websites where alice is an owner (Facebook, CNN)
   
   select website.`name`,username, role
   from website, website_role, developer, person
   where website.id=website_role.web_id and website_role.developer_id=developer.id and developer.id=person.id
         and username='alice' and role='owner';
   
   #e Retrieve all websites where charlie is an admin and get more than 6000000 visits
   
   select website.`name`, username, role, visits
   from website, website_role, developer, person
   where website.id=website_role.web_id and website_role.developer_id=developer.id and developer.id=person.id
         and username='charlie' and role='admin' and visits>6000000;
         
         
	#Retrieve pages
    #a Retrieve the page with the most number of views
    
    select id, title, description, created, updated, max(views) as most_view
    from `page`
    where views=(select max(views) from `page`);
    
    #select * from `page` 
    #order by views desc
    #limit 1;
    
    #b Retrieve the title of a page whose id is 234
    
    select id,title from `page` where id=234;
    
    #c Retrieve all pages where alice is an editor (Home, Preferences)
    
    select title, username, role
    from `page`, page_role, developer,person
    where `page`.id=page_role.page_id and page_role.developer_id=developer.id and developer.id=person.id
           and username='alice' and role='editor';
    
    #d Retrieve the total number of page views in CNET
    
    select sum(views) as total_view_cnet from `page`, website
    where `page`.web_id=website.id and `name`='cnet';
    
    #e Retrieve the average number of page views in the Website Wikipedia
    
    select avg(views) as avg_view_wiki from `page`, website
    where `page`.web_id=website.id and `name`='wikipedia';

	#Retrieve widgets
    #a Retrieve all widgets in CNET's Home page
    
    select widget.`name`, website.`name`, `page`.title
    from widget, `page`, website
    where widget.page_id=`page`.id and `page`.web_id=website.id 
          and website.`name`='cnet' and `page`.title='home';
    
    #b Retrieve all youtube widgets in CNN
    
    select widget.`name`, dtype, website.`name`, `page`.title
    from widget, `page`, website
	where widget.page_id=`page`.id and `page`.web_id=website.id 
         and dtype='youtube' and website.`name`='cnn';
    
    #c Retrieve all image widgets on pages reviewed by Alice
    
    select widget.`name`, dtype, title, username, role
    from widget, `page`, page_role, developer, person
    where widget.page_id=`page`.id and `page`.id=page_role.page_id 
          and page_role.developer_id=developer.id and developer.id=person.id
          and dtype='image' and username='alice' and role='reviewer';
    
    #d Retrieve how many widgets are in Wikipedia

    select count(widget.id) as num_wid_wiki
    from widget, `page`, website
    where widget.page_id=`page`.id and `page`.web_id=website.id and website.`name`='wikipedia';



    #To verify the page and website triggers written earlier function properly:
    #a Retrieve the names of all the websites where Bob has DELETE privileges. 
    #Answer: Twitter, Wikipedia, CNET, Gizmodo (where Bob has either owner or admin roles).
    
    select  web_name, username, web_role, web_priviledge
    from deleveloper_roles_and_privileges
    where username='bob' and web_priviledge='delete'
    group by web_name;
    
    #b Retrieve the names of all the pages where Charlie has CREATE privileges. 
    #Answer: Home, Preferences (where Charlie has Writer role)
    
    select page_title, username, page_role_, page_priviledge_
    from deleveloper_roles_and_privileges
    where username='charlie' and page_priviledge_='create'
    group by page_title;
