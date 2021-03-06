Image.create!([
  {url: "http://ecx.images-amazon.com/images/I/81vPzG13LRL._SL1500_.jpg", product_id: 1},
  {url: "http://annmariebone.com/content/images/thumbs/0000174_rainbow_tree.jpeg", product_id: 2},
  {url: "http://images.clipartpanda.com/thing-thing1_color.png", product_id: 3},
  {url: "http://ecx.images-amazon.com/images/I/81e0PQxZ%2BmL._SL1500_.jpg", product_id: 1},
  {url: "https://i.ytimg.com/vi/D9c02cZuDZI/hqdefault.jpg", product_id: 22},
])
Order.create!([
  {user_id: 1, quantity: 5, product_id: 22, subtotal: "5.0", tax: "0.45", total: "5.45"},
  {user_id: 1, quantity: 1, product_id: 1, subtotal: "12.5", tax: "1.13", total: "13.63"}
])
Product.create!([
  {name: "Chia Pet", price: "12.5", description: "Ch-ch-ch-ch CHI-uh!", in_stock: true, supplier_id: 1, user_id: 1},
  {name: "Rainbow Tree", price: "1000000.0", description: "Whoa!", in_stock: false, supplier_id: 1, user_id: 1},
  {name: "Thing 1", price: "1.0", description: "Sold w/o thing 2 :(", in_stock: true, supplier_id: 2, user_id: 1},
  {name: "Crazy Bones", price: "5.0", description: "Why you crazy bone?......", in_stock: true, supplier_id: 2, user_id: 1}
])
Supplier.create!([
  {company_name: "Acme", email: "acme@acme.com", phone: "6-12344566"},
  {company_name: "Motley Industries", email: "motley@harrisoncrew.com", phone: "2424242 ext:garage#"},
])
