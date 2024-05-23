/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author duongvu
 */
public class Setting {
    /*
    id INT PRIMARY KEY,
    name VARCHAR(255),
    value VARCHAR(10),
    setting_type_id INT,
    order INT,
    status VARCHAR(50),
    description TEXT,
    */
    private int id, settingTypeId, order,value;
    private String name, description,type,status;

    public Setting() {
    }

    public Setting(int id, int settingTypeId, int order, String name, int value, String status, String description) {
        this.id = id;
        this.settingTypeId = settingTypeId;
        this.order = order;
        this.name = name;
        this.value = value;
        this.status = status;
        this.description = description;
    }
    public Setting(int id, int settingTypeId,String type, int order, String name, int value, String status, String description) {
        this.id = id;
        this.settingTypeId = settingTypeId;
        this.type = type;
        this.order = order;
        this.name = name;
        this.value = value;
        this.status = status;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSettingTypeId() {
        return settingTypeId;
    }

    public void setSettingTypeId(int settingTypeId) {
        this.settingTypeId = settingTypeId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}
