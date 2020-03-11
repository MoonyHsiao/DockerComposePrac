
 USE rockman; CREATE TABLE `courses` ( `id` int (10) unsigned NOT NULL AUTO_INCREMENT,
         `created_at` timestamp NULL DEFAULT NULL,
         `updated_at` timestamp NULL DEFAULT NULL,
         `deleted_at` timestamp NULL DEFAULT NULL,
         `description` varchar (255) DEFAULT NULL,
         `icon_url` varchar (255) DEFAULT NULL,
         `course_list_icon` varchar (255) DEFAULT NULL,
         `long_description` varchar (255) DEFAULT NULL,
         `category` varchar (255) DEFAULT NULL,
         `lessons_count` int (11) DEFAULT NULL,
         PRIMARY KEY (`id`),
         KEY `idx_courses_deleted_at` (`deleted_at`) ) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8; 
         

        INSERT INTO `rockman`.`courses` (`id`,
         `created_at`,
         `updated_at`,
         `description`,
         `icon_url`,
         `course_list_icon`,
         `long_description`,
         `category`,
         `lessons_count`) 
        VALUES (1,
         '2019-05-09 12:48:45','2019-05-09 12:48:45', "Angular for Beginners", 'https://angular-academy.s3.amazonaws.com/thumbnails/angular2-for-beginners-small-v2.png', 'https://angular-academy.s3.amazonaws.com/main-logo/main-page-logo-small-hat.png', "Establish a solid layer of fundamentals, learn what's under the hood of Angular", 'BEGINNER', 10), (2,'2019-05-09 12:48:45','2019-05-09 12:48:45', 'Angular Security Course - Web Security Fundamentals', 'https://s3-us-west-1.amazonaws.com/angular-university/course-images/security-cover-small-v2.png', 'https://s3-us-west-1.amazonaws.com/angular-university/course-images/lock-v2.png', "Learn Web Security Fundamentals and apply them to defend an Angular / Node Application from multiple types of attacks.", 'ADVANCED', 11), (3,'2019-05-09 12:48:45','2019-05-09 12:48:45', 'Angular PWA - Progressive Web Apps Course', 'https://s3-us-west-1.amazonaws.com/angular-university/course-images/angular-pwa-course.png', 'https://s3-us-west-1.amazonaws.com/angular-university/course-images/alien.png', "<p class='course- '>Learn Angular Progressive Web Applications, build the future of the Web Today.", 'ADVANCED', 8), (4,'2019-05-09 12:48:45','2019-05-09 12:48:45', 'Angular NgRx Store Reactive Extensions Architecture Course', 'https://angular-academy.s3.amazonaws.com/thumbnails/ngrx-angular.png', 'https://angular-academy.s3.amazonaws.com/thumbnails/ngrx-small.png', "Learn how to the Angular NgRx Reactive Extensions and its Tooling to build a complete application.", 'ADVANCED', 0), (5,'2019-05-09 12:48:45','2019-05-09 12:48:45', 'The Complete Typescript Course', 'https://angular-academy.s3.amazonaws.com/thumbnails/typescript-2-small.png', 'https://angular-academy.s3.amazonaws.com/thumbnails/typescript-2-lesson.png', "Complete Guide to Typescript From Scratch: Learn the language in-depth and use it to build a Node REST API.", 'BEGINNER', 15), (6,'2019-05-09 12:48:45','2019-05-09 12:48:45', 'Rxjs
        AND Reactive Patterns Angular Architecture Course', 'https://s3-us-west-1.amazonaws.com/angular-academy/blog/images/rxjs-reactive-patterns-small.png', 'https://angular-academy.s3.amazonaws.com/course-logos/observables_rxjs.png', "Learn the core RxJs Observable Pattern as well and many other Design Patterns for building Reactive Angular Applications.", 'BEGINNER' ,0), (7,'2019-05-09 12:48:45','2019-05-09 12:48:45', "Angular Material Course", "https://s3-us-west-1.amazonaws.com/angular-university/course-images/material_design.png", "https://s3-us-west-1.amazonaws.com/angular-university/course-images/material_design.png", "Build Applications with the official Angular Widget Library", 'ADVANCED', 4); 


