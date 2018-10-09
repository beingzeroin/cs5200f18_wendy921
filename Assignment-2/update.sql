

    use assignment2_congwen;

    #Implement Queries
   
	  #Implement Updates 
    
    #a Update developer - Update Charlie's primary phone number to 333-444-5555
    
    update phone
    set phone.phone='333-444-5555' 
    where person_id=(select id from person where username='charlie') and `primary`=1;
    
    #b Update widget - Update the relative order of widget head345 on the page so that it's new order is 3. 
    #Note that the other widget's order needs to update as well
    
    #update value of updated in page and website when update/delete/insert widget
    
    delimiter //
    
    drop trigger if exists after_widget_update//
    
    create trigger after_widget_update 
    after update on widget for each row
    
    begin
    
    update `page`
    set `page`.updated=curdate()
    where `page`.id=old.page_id;
    
    update website join `page`on (`page`.web_id=website.id)
    set website.updated=curdate()
    where website.id=(select web_id from `page` where `page`.id=old.page_id);
    
    end//
    
    
    
    #########################################
    
    
    delimiter //
    
    drop trigger if exists after_widget_delete//
    
    create trigger after_widget_delete 
    after delete on widget for each row
    
    begin
    
    update `page`
    set `page`.updated=curdate()
    where `page`.id=old.page_id;
    
    update website join `page`on (`page`.web_id=website.id)
    set website.updated=curdate()
    where website.id=(select web_id from `page` where `page`.id=old.page_id);
    
    end//
    
    ###################################
    
    delimiter //
    
    drop trigger if exists after_widget_insert//
    
    create trigger after_widget_insert 
    after insert on widget for each row
    
    begin
    
    update `page`
    set `page`.updated=curdate()
    where `page`.id=new.page_id;
    
    update website join `page`on (`page`.web_id=website.id)
    set website.updated=curdate()
    where website.id=(select web_id from `page` where `page`.id=new.page_id);
    
    end//
    
    ###########################
    
    #update order
    
    SET SQL_SAFE_UPDATES = 0;
    
    update widget 
    set `order`=
    (case
    when `order`=1 then  3
    when `order`=2 then  1
    when `order`=3 then  2
    end )
    where `order` in (1,2,3);
    
    SET SQL_SAFE_UPDATES = 1;
    
        
    
    #c Update page - Append 'CNET - ' to the beginning of all CNET's page titles
    
    SET SQL_SAFE_UPDATES = 0;
    
    update `page` join website on (`page`.web_id=website.id)
    set 
    title=concat('CNET-',title)
    where  `name`='cnet';
    
    SET SQL_SAFE_UPDATES = 1;
    
    #d Update roles - Swap Charlie's and Bob's role in CNET's Home page
    
    SET SQL_SAFE_UPDATES = 0;
    
    update
    page_role as p_r join
    (select username as user1,role as role1,`name` as name1,title as title1,developer_id as dev1, page_id as page1 
        from (person join developer on(person.id=developer.id and username in ('bob','charlie')) 
        join page_role on (developer.id=page_role.developer_id) 
            join `page` on (page_role.page_id=`page`.id and title='cnet-home') 
            join website on (website.id=`page`.web_id and `name`='cnet'))) as swap
		on( p_r.page_id=page1)
    
     set p_r.role=role1
     
     where (developer_id=(select id from person where username='bob') 
                and dev1=(select id from person where username='charlie')) 
	  or
                
	       (developer_id=(select id from person where username='charlie') 
                and dev1=(select id from person where username='bob'));
    
    
    SET SQL_SAFE_UPDATES = 1;
