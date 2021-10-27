class Hotel < ApplicationRecord
  with_options on: :create do
  validates :hotel_name, presence: true, length: { maximum: 30 }
  validates :hotel_introduction, presence: true
  validates :hotel_price, presence: true, numericality: { only_integer: true }
  validates :hotel_address, presence: true
  validates :user_id, presence: true, numericality: { only_integer: true }
  validate :hotel_image_type, :hotel_image_size
  end

  with_options on: :booking_confirm do
  validate :not_before_day
  validate :is_after_day
  validates :hotel_id, presence: true, numericality: { only_integer: true }
  validates :client_num, presence: true, numericality: { only_integer: true }
  end

  with_options on: :booking_complete do
  validate :not_before_day
  validate :is_after_day
  validates :total_price, presence: true, numericality: { only_integer: true }
  validates :hotel_id, presence: true, numericality: { only_integer: true }
  validates :client_num, presence: true, numericality: { only_integer: true }
  validates :using_days, presence: true, numericality: { only_integer: true }
  end


  has_one_attached :hotel_image


  belongs_to :user
  has_many :bookings




  private
  
  def hotel_image_type
    if (hotel_image.attached?)
      if !hotel_image.blob.content_type.in?(%('hotel_image/jpeg hotel_image/png'))
        hotel_image.purge
        errors.add(:hotel_image, "はjpegまたはpng形式でアップロードしてください")
      end
    else
      errors.add(:hotel_image, "画像をアップロードしてください")
    end
  end

  def hotel_image_size
    if hotel_image.attached?
      if hotel_image.blob.byte_size > 5.megabytes
        hotel_image.purge
        errors.add(:hotel_image, "は1つのファイル5MB以内にしてください")
      end
    end
  end

  def not_before_day
    errors.add(:check_in, 'は明日以降の日付を入力して下さい') if check_in.nil? || check_in >= Date.today
  end

  def is_after_day
    errors.add(:check_in, 'は終了日以降の日付を入力して下さい') if check_in.nil? || check_in <= check_out
  end



end
