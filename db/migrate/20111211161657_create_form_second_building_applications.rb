class CreateFormSecondBuildingApplications < ActiveRecord::Migration
  def change
    create_table :form_second_building_applications do |t|
      t.string :zhubandanwei
      t.string :fuzeren
      t.string :xingming
      t.string :yuanxi
      t.string :lianxifangshi
      t.string :zhujiangren
      t.string :gongzuodanwei
      t.string :zhicheng
      t.string :yanjiangtimu
      t.string :fangyingneirong
      t.string :huodongxingshi
      t.date :huodongshijian
      t.integer :startclass
      t.integer :endclass
      t.integer :huodongrenshu
      t.string :zhidaozhongxin
      t.string :jiaowuzhang
      t.string :classroom
      t.string :beizhu
      t.integer :status
      t.references :group

      t.timestamps
    end
    add_index :form_second_building_applications, :group_id
  end
end
