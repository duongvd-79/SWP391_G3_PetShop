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
    int id, settingTypeId, order;
    String name, value, status, description;

    public Setting() {
    }

    public Setting(int id, int settingTypeId, int order, String name, String value, String status, String description) {
        this.id = id;
        this.settingTypeId = settingTypeId;
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

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
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
