class Customer < ApplicationRecord
  belongs_to :user

  #class methods
  def self.all_customers(user_id)
    Customer.find_by_sql("
      SELECT *
      FROM customers AS c
      WHERE #{user_id} = c.user_id
      ")
    end
    def self.single_customer(user_id, customer_id)
      Customer.find_by_sql(["
        SELECT *
        FROM customers AS c
        WHERE c.id = ? AND c.user_id = ?
        ", customer_id, user_id]).first
    end

    def self.create_customer(p, user_id)
      Customer.find_by_sql(["

        INSERT INTO customers (first_name, last_name, email, phone, user_id, created_at, updated_at)
        VALUES (:first, :last, :email, :phone, :user_id, :created_at, :updated_at)
        ", {
          first: p[:first_name],
          last: p[:last_name],
          email: p[:email],
          phone: p[:phone],
          user_id: user_id,
          created_at: DateTime.now,
          updated_at: DateTime.now
        }])

    end
    def self.update_customer(customer_id, p)
      Customer.find_by_sql(["
        UPDATE customers AS c
        SET first_name = ?, last_name = ?, email = ?, phone = ?, updated_at = ?, created_at = ?
          ",  p[:first_name],
           p[:last_name],
           p[:email],
           p[:phone],
           DateTime.now,
           DateTime.now

          ])
          

    end
    def self.delete_customer(customer_id)
      Customer.find_by_sql(["
        DELETE FROM customers AS c
        WHERE C.ID = ?
          ", customer_id])

    end
    #instance method

    def full_name
      "#{self.first_name} #{self.last_name}"

    end
end
