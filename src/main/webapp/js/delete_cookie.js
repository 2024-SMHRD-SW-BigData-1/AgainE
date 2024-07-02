$(document).ready(function() {
	
	deleteCookie("found_user_id", '/');
	deleteCookie("found_user_name", '/');
	deleteCookie("found_user_pw", '/');
	deleteCookie("target_id", '/');
	
	
	
	
	 function deleteCookie(name, path) {
            if (path === undefined) {
                path = '/';
            }
            document.cookie = name + '=; Path=' + path + '; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
        }
	
	
	
	
	
	
	
	
	
	
	
});