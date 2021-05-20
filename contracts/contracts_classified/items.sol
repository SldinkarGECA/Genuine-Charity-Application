struct product{
        string productId;
        string productName;
        uint price;
        address payable seller;
        bool ongoing;
        
           }
      
 mapping (string => product) products;
 product[] public allProducts;           

function addProduct(string memory _productId, string memory _productName, uint _price) public {
       require(!products[_productId].ongoing);
      
       
       product memory product = product(_productId, _productName, _category, _price, msg.sender, true);  
       products[_productId].productId= _productId;
       products[_productId].productName= _productName;   
       products[_productId].price= _price;   
       products[_productId].seller= msg.sender; 
       products[_productId].ongoing = true;
       allProducts.push(product);
          
                     
        
}           
