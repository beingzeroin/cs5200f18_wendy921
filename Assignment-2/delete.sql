

    use assignment2_congwen;

    #Implement Queries
   
    #Implement Deletes 
	#a Delete developer - Delete Alice's primary address
    
    delete from address
    where person_id=(select id from person where username='alice') and `primary`=1;
    
	#b Delete widget - Remove the last widget in the Contact page. 
    #The last widget is the one with the highest value in the order field
    
    SET SQL_SAFE_UPDATES = 0;
    
    delete from widget
    where `order`= (select max_order from (select max(`order`) as max_order from widget) as w);
    
    SET SQL_SAFE_UPDATES = 1;
    
    #c Delete page - Remove the last updated page in Wikipedia
    
	delimiter //
    create trigger before_page_delete
    before delete on `page` for each row
    
    begin
    
    delete from page_role where page_role.page_id=old.id;
    
    end//
    
    
    delete from `page`
    where web_id=(select id from website where `name`='wikipedia') 
          and updated=(select max_updated from (select max(updated) as max_updated from`page`) as p);
          
    
    #d Delete website - Remove the CNET web site, as well as all related roles and privileges 
    #relating developers to the Website and Pages
	
	delimiter //
    
	drop trigger if exists before_website_delete//
    
    create trigger before_website_delete
    before delete on website for each row
    
    begin
    
    delete from website_role where website_role.web_id=old.id;
    
    
    end//
        
    
    SET SQL_SAFE_UPDATES = 0;
    
    delete from `page`
    where `page`.web_id=(select id from website where `name`='cnet');
    
    delete from website
    where `name`='cnet'; 
    
    SET SQL_SAFE_UPDATES = 1;
