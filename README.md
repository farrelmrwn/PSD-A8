# 🥤 SODA DISPENSING MACHINE 🥤
Dalam dunia industri makanan dan minuman, tentunya memerlukan berbagai macam inovasi untuk dapat berjalan sesuai dengan majunya teknologi. Maka dari itu, kami dari kelompok A8 melakukan inovasi dalam industri ini, yaitu kami membuat Soda Dispensing Machine. 

#Deskripsi Proyek
FPGA yang kami buat adalah Soda Dispensing Machine yang akan menerima pesanan dari pelanggan dan memberitahu pelanggan berapa banyak uang yang harus dibayar. Mesin kami memiliki beberapa jenis minuman dengan ukuran gelas yang bisa dipilih oleh pelanggan. Harga dari Minuman ini tentunya akan berbeda untuk jenis soda dan ukuran yang dipilih oleh pelanggan. Jenis dari sodanya pun ada 2, yaitu pepsi dan coke. Harga dari masing-masing soda untuk pepsi yaitu seharga 5 ribu rupiah dan coke seharga 10 ribu rupiah. Ukuran dari soda nya juga akan menentukan harga akhir, jika memilih medium maka harga soda akan ditambah 5 ribu rupiah dan big akan ditambah 10 ribu rupiah.

Ketika user telah memilih soda dan ukuran yang akan dibeli, Selanjutnya user akan ditanya apakah memiliki akun atau tidak. Jika user tidak memiliki akun, maka akan masuk ke mode guest dimana user harus memasukan uang yang akan dideteksi oleh sensor. Nantinya mesin akan menampilkan harga dari soda dan menghitung uang yang masuk sekaligus memberikan uang kembalian jika uang yang dimasukkan oleh user berlebih. Namun jika user memiliki akun, maka user tidak perlu memasukan uang namun balance dari akun tersebut akan berkurang dengan sendirinya.

Soda Dispencing Machine will be written entirely in VHDL and it will have a lot of features and that is :
 - Member / Guest Selection
 - Inserting money and receiving changes
 - Two beverages that can be choosen with different prices
 - Seven Segment to display the amount of money that will be paid
 - Selection of cup sizes

# Tujuan
 - Mengimplementasikan bahasa VHDL ke barang yang biasa kita temukan sehari-hari.
 - Dapat membuat desain Finite State Machine menggunakan bahasa VHDL.
 - Bekerja sama dengan baik dalam membuat mesin dengan bahasa pemrograman VHDL.
 - Mengasah ilmu VHDL untuk bekal masa depan nanti.

# Implementation
Tools yang digunakan pada project ini adalah : 
 - VSCode
 - ModelSim
 - Draw.io
 - Github
 - Quartus Prime

State default dari Soda Dispensing Machine kami berada pada idle yang akan menerima input dari user untuk memilih jenis soda. Kemudian berdasarkan input dari user mesin akan berpindah state sesuai soda yang dipilih dan harga default dari soda yang dipilih akan ditambahkan ke total harga yang harus dibayar. Setelah itu, mesin akan meminta input lagi dari user untuk memilih ukuran soda yang akan memengaruhi harga total yang harus dibayar user. 

Setelah user memilih ukuran soda, maka harga total yang harus dibayarkan user akan ditampilkan pada display seven segment. Pada state ini user diminta untuk memasukan total uang yang sesuai dengan total yang ditampilkan display. Jika total uang sudah dibayarkan maka state akan berubah menjadi state dispensing dimana state ini akan menyajikan soda ke user. Namun ada cara pembayaran alternatif untuk user yaitu dengan member, jika user memilih cara pembayaran member setelah memilih ukuran soda maka state mesin akan langsung berubah ke dispensing.

# Testing & Results
Using Test Bench :
Test bench adalah sebuah metode yang dapat digunakan untuk mensimulasikan dan mengetes sebuah kode pada VHDL. Ciri khas dari Test Bench adalah pada bagian entity nya kosong, dan pada bagian architecture diberikan komponen yang berasal dari file vhd yang ingin di tes.

Kelompok kami membuat 2 Test bench yaitu :
 - Test Bench untuk FSMDispenser
 - Test Bench untuk seven segment 

States yang digunakan :
 - Idle
 State ini merupakan states default dari program ini, state ini menandakan bahwa mesin sedang dalam keadaaan Idle dan siap untuk menerima input dari user. Pada states idle ini semua output di set menjadi bernilai 0.
 - Select Drink (Pepsi, Coke)
State ini terdiri dari 2 yaitu Pepsi (0) dan Coke (1), kedua state ini memiliki value price yang berbeda dengan harga Pepsi 5k dan harga Coke sebesar 10k. Setelah masuk state ini bisa lanjut ke state size.
 - Select Size (Small, Medium, Big)
State ini terdiri dari 3 yaitu Small (00), Medium (01), Big (10). Ketiga state ini juga memiliki harga yang berbeda berdasarkan size dan drink nya dengan penjabaran sebagai berikut :
     - Pepsi
      (5 k = Small, 10 k = Medium, 15 k = Big)
     - Coke
      (10 K = Small, 15 k = Medium, 20 k = Big)
 - Select Account (Guest, Member)
State ini digunakan untuk memilih antara 2 akun yang ada yaitu antara guest atau member, untuk guest membayar menggunakan uang fisik sedangkan untuk member langsung akan mendapatkan minumannya.
 - Insert Money (Money_0, Money_5, Money_10, Money_15, Money_20)
Insert state money ini hanya akan aktif apabila sensor menyala atau bernilai 1 apabila sensor menyala state akan berubah ke state money_0 atau state siap menerima uang. Untuk uang yang bisa masuk adalah 5k dan 10k dan maksimal uang yang bisa masuk adalah 20k. Pada state ini setiap uang yang masuk akan diakumulasi dan uang yang diakumulasi ini akan digunakan lagi pada state berikutnya yaitu state check.
 - Check
State Check ini adalah state yang digunakan untuk mengecek apakah uang yang diakumulasikan tadi lebih besar atau lebih kecil dari total harga minuman apabila uang akumulasi lebih kecil maka state akan dikembalikan ke state money_0 namun apabila uang yang diakumulasikan lebih besar dari total harga maka bisa memberikan kembalian dengan cara mengurangi akumulasi dengan harga
 - Dispense
 State ini adalah state terakhir yang memiliki fungsi untuk mengeluarkan soda dan mengeluarkan kembalian. Setelah state ini akan kembali lagi ke state idle.




