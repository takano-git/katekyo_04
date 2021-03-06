class Attendance < ApplicationRecord
  belongs_to :user

  attr_accessor :attendance_id      #モデルに基づかない項目をform_withで送信する場合に記載
  # enum lesson_status_23: {授業の設定なし: 0, 授業の設定有り:1, 申請中:2, 承認:3, 否認: 4}  # 試しに追加
  # enum lesson_status_22: {授業の設定なし: 0, 授業の設定有り:1, 申請中:2, 承認:3, 否認: 4}  # 試しに追加
  # enum lesson_status_23: {授業の設定なし: 0, 授業の設定有り:1, 申請中:2, 承認:3, 否認: 4}  # 試しに追加


  validates :worked_on, presence: true
  validates :note, length: { maximum:50 }
  
  # 出勤時間が存在しない場合、退勤時間は無効
  validate :finished_at_is_invalid_without_a_started_at
  
  # 出勤・退勤時間どちらも存在するとき、出勤時間より早い退勤時間は無効
  validate :started_at_than_finished_at_fast_if_invalid
  
  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
  
  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です") if started_at > finished_at
    end
  end
end
