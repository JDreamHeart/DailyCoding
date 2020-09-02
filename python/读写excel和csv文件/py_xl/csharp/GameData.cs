using System.Collections.Generic;

class GameData {
    Dictionary<string, TableData> m_dataDict = new Dictionary<string, TableData>();

    GameData m_instance;

    public static GameData Instance() {
        if (m_instance != null) {
            return m_instance;
        }
        m_instance = new GameData();
        return m_instance;
    }

    public TableData<T> this[string name] {
        get {
            if (!this.m_dataDict.ContainsKey(name)) {
                this.m_dataDict.Add(name, new TableData<T>());
            }
            return this.m_dataDict[name];
        }
    }
}

public class TableDataCreater {
    protected Dictionary<string, System.Type> m_typeDict = new Dictionary<string, System.Type>();

    protected Dictionary<string, object[,]> m_argsDict = new Dictionary<string, object[,]>();

    public System.Type GetTypeByName(string name) {
        if (m_typeDict.ContainsKey(name)) {
            return m_typeDict[name];
        }
        return null;
    }
    
    public object[,] GetArgsByName(string name) {
        if (m_argsDict.ContainsKey(name)) {
            return m_argsDict[name];
        }
        return null;
    }
}