# Sử dụng hình ảnh Node.js
FROM node:14-alpine

# Thiết lập thư mục làm việc
WORKDIR /usr/src/app

# Sao chép package.json và cài đặt phụ thuộc
COPY package*.json ./
RUN npm install --only=production

# Sao chép mã nguồn
COPY . .

# Mở cổng
EXPOSE 8080

# Lệnh khởi động ứng dụng
CMD [ "npm", "start" ]
